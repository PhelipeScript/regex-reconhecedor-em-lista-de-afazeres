# Sistema de Reconhecimento de Tarefas em Listas de Afazeres

## Descrição do Projeto

Este projeto implementa um sistema de reconhecimento de padrões em listas de tarefas usando expressões regulares em Ruby. O objetivo é extrair informações estruturadas a partir de descrições de tarefas em linguagem natural.

## Funcionalidades

O sistema é capaz de reconhecer e extrair os seguintes elementos de uma lista de tarefas:

### 1. Horários
- Formatos suportados:
  - `10 horas`
  - `1 hora`
  - `10:30`
  - `10 30`
  - `às 10:30`
  - `às 10 30`
  - `às 10`

### 2. Dias e Datas
- Reconhece:
  - Datas específicas: `28 de Fevereiro`, `13 de agosto de 2021`
  - Formatos de data: `30/01`, `20/04/2022`
  - Datas relativas: `hoje`, `amanhã`, `depois de amanhã`, `segunda-feira`, `terça-feira`, `quarta-feira`, `quinta-feira`, `sexta-feira`, `sábado`, `domingo`,

### 3. Tags
- Identifica tags precedidas por `#`
- Exemplos: `#casa`, `#trabalho`

### 4. URLs
- Extrai URLs completas
- Exemplo: `https://sp.senac.br/pag1#teste?aula=1&teste=4`

### 5. Emails
- Reconhece endereços de email
- Exemplo: `jose.da-silva@sp.senac.br`

### 6. Ações e Pessoas
- Identifica ações como: `agendar`, `marcar`, `ligar`
- Seguidas de conectores como: `com`, `e`, `ou`, 
- Detecta pessoas associadas à ação
- Exemplos: 
  - `agendar com Pedro`
  - `marcar com José`
  - `reunião com Maria`
  - `reunião com Pedro e João`

## Exemplo de Uso
### Múltiplas tarefas
```ruby
listas_tarefas = [
  "Agendar com Maria reunião às 14:00 hoje #trabalho maria-da-silva@hotmail.com",
  "Marcar com João revisão do projeto às 16:30 amanhã #revisao #projeto"
]

reconhecer_lista(listas_tarefas)
```
### Única tarefa 
```ruby
tarefa = 'Agendar com José reunião às 10:00 amanhã #trabalho'
reconhecer_lista(tarefa)
```

## Saída Exemplo

```
1º Tarefa:
Ações: Agendar
Pessoas: Maria
Data: 26/03/2025
Horário: 14:00
Tags: trabalho
Emails: maria-da-silva@hotmail.com
URLs: não encontrado

2º Tarefa:
Ações: Marcar
Pessoas: João
Data: 27/03/2025
Horário: 16:30
Tags: revisao, projeto
Emails: não encontrado
URLs: não encontrado
```

## Requisitos

- Ruby 2.7 ou superior
- Biblioteca padrão `date` para pegar os dias `hoje`, `amanhã` e `depois de amanhã`

## Contribuição

Sinta-se à vontade para abrir issues ou enviar pull requests para melhorar o sistema de reconhecimento.

## Autor

Made by Phelipe Pereira 💜
