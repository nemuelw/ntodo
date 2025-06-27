import jsony, os, strformat

type
  TodoItem = object
    id: int
    title: string
    done*: bool

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

proc list_todos() =
  for todo in todos:
    let status = if todo.done: "[x]" else: "[ ]"
    echo fmt"{status} ({todo.id}) {todo.title}"

proc mark_todo_as_done(id: int) =
  for i in 0..<todos.len:
    if todos[i].id == id: todos[i].done = true

when isMainModule:
  echo("ntodo")
  todos = load_todos()
  add_todo("Buy milk from the shop")
  list_todos()
  mark_todo_as_done(1)
  list_todos()
