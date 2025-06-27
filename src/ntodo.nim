import jsony, os

type
    TodoItem = object
      id: int
      title: string
      done: bool

const TodoFile = "todos.json"
var todos: seq[TodoItem]

proc load_todos(): seq[TodoItem] =
  if not fileExists(TodoFile):
    return @[]
  let raw = readFile(TodoFile)
  fromJson(raw, seq[TodoItem])

proc add_todo(title: string) =
  let todo = TodoItem(id: todos.len + 1, title: title, done: false)
  todos.add(todo)

when isMainModule:
  echo("ntodo")
  todos = load_todos()
  add_todo("Buy milk from the shop")
  echo todos
