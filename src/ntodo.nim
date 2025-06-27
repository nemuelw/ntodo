import jsony, os, sequtils, strformat

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

proc edit_todo(id: int, new_title: string) =
  for i in 0..<todos.len:
    if todos[i].id == id: todos[i].title = new_title

proc delete_todo(id: int) =
  todos = todos.filterIt(it.id != id)
  for i, todo in todos:
    todos[i].id = i + 1

proc save_todos() =
  writeFile(TodoFile, toJson(todos))

when isMainModule:
  echo("ntodo")
  todos = load_todos()
  list_todos()
  delete_todo(1)
  list_todos()
  save_todos()
