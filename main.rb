require 'date'

def transformar_para_string(array_or_value)
  if array_or_value.is_a?(Array) && array_or_value.empty?
    "não encontrado"
  else
    array_or_value.is_a?(Array) ? array_or_value.join(", ") : array_or_value
  end
end

def reconhecer_lista(lista)
  horarios = /\b(\d{2} horas|\d{1} hora|\d{2}:\d{2}|\d{2} \d{2}|às \d{2}:\d{2}|às \d{2} \d{2}|às \d{2})\b/
  dias_datas = /\b(hoje|depois de amanhã|amanhã|[Ss]egunda-feira|[Tt]erça-feira|[Qq]uarta-feira|[Qq]uinta-feira|[Ss]exta-feira|[Ss]egunda|[Tt]erça|[Qq]uarta|[Qq]uinta|[Ss]exta|[Ss][aá]bado|[Dd]omingo|\d{2} [a-z]{2} [A-Za-z]+ de \d{4}|\d{2} [a-z]{2} [A-Za-z]+|\d{2}\/\d{2}\/\d{4}|\d{2}\/\d{2})\b/
  tags = /(?<=\s|^)#([A-Za-z][A-Za-z0-9_-]*[A-Za-z0-9])(?=\s|$)/
  urls = /\bhttps?:\/\/[a-zA-Z][a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\/?[^\s]*\b/
  emails = /\b([A-Za-z][A-Za-z0-9.\-_]+@[A-Za-z]{2,}\.[A-Za-z]{2,}(\.[A-Za-z]{2,})?)\b/
  acoes = /\b([Aa]gendar|[Mm]arcar|[Ll]igar|[Aa]grupar|[Pp]lanejar|[Oo]rganizar|[Cc]onversar|[Dd]iscutir|[Ee]ncontrar|[Rr]eunião|[Rr]evisar)\s+[A-Za-zÀ-ÿ]*\s*(com|e|ou|para)\b/
  pessoas = /\b(com|e|ou|para)\s+([A-Z][A-Za-zÀ-ÿ]+)\b/

  resultado = ""
  hoje = Date.today

  Array(lista).each_with_index do |list, index|
    valor_horarios = transformar_para_string(list.scan(horarios).flatten)
    valor_dias_datas = transformar_para_string(list.scan(dias_datas).flatten)
    if valor_dias_datas == 'hoje'
      valor_dias_datas = hoje.strftime('%d/%m/%Y')
    elsif valor_dias_datas == 'amanhã'
      amanha = hoje + 1
      valor_dias_datas = amanha.strftime('%d/%m/%Y')
    elsif valor_dias_datas == 'depois de amanhã'
      depois_de_amanha = hoje + 2
      valor_dias_datas = depois_de_amanha.strftime('%d/%m/%Y')
    end
    valor_tags = transformar_para_string(list.scan(tags).flatten)
    valor_urls = transformar_para_string(list.scan(urls).flatten)
    valor_emails = transformar_para_string(list.scan(emails).flatten)
    valor_acoes = transformar_para_string(list.scan(acoes).flatten[0])
    valor_pessoas = transformar_para_string(list.scan(pessoas).flatten.map.each_with_index.select { |value, index| index.odd? }.map { |value, index| value })

    resultado << "#{index+1}º Tarefa:\nAções: #{valor_acoes}\nPessoas: #{valor_pessoas}\nData: #{valor_dias_datas}\nHorário: #{valor_horarios}\nTags: #{valor_tags}\nEmails: #{valor_emails}\nURLs: #{valor_urls}\n\n"
  end

  puts resultado
end

listas_tarefas = [
  "Agendar com Maria reunião às 14:00 hoje #trabalho maria-da-silva@hotmail.com",
  "Marcar com João revisão do projeto às 16:30 amanhã #revisao #projeto",
  "Reunião com Jorge da equipe de design às 09:00 quarta-feira #trabalho",
  "Reunião com Henrique da equipe técnica às 10:00 13 de agosto de 2021 #projeto",
  "Agendar entrevista com Antonio às 14:30 terça #RH #entrevista",
  "Revisar contrato com Marcos do jurídico às 10:00 depois de amanhã #legal https://empresa.com/contrato juridico@legal.com",
]

reconhecer_lista(listas_tarefas)
