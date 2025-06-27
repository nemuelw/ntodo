import cligen, jsony, os, sequtils, strformat

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

proc save_todos() =
  writeFile(TodoFile, toJson(todos))

proc add_todo(title: string) =
  let todo = TodoItem(id: todos.len + 1, title: title, done: false)
  todos.add(todo)
  save_todos()

proc list_todos() =
  for todo in todos:
    let status = if todo.done: "[x]" else: "[ ]"
    echo fmt"{status} ({todo.id}) {todo.title}"

proc mark_todo_as_done(id: int) =
  for i in 0..<todos.len:
    if todos[i].id == id: todos[i].done = true
  save_todos()

proc edit_todo(id: int, title: string) =
  for i in 0..<todos.len:
    if todos[i].id == id: todos[i].title = title
  save_todos()

proc delete_todo(id: int) =
  todos = todos.filterIt(it.id != id)
  for i, todo in todos:
    todos[i].id = i + 1
  save_todos()

proc init(title: string) = add_todo(title)
proc list() = list_todos()
proc edit(id: int, title: string) = edit_todo(id, title)
proc done(id: int) = mark_todo_as_done(id)
proc remove(id: int) = delete_todo(id)

when isMainModule:
  todos = load_todos()
  dispatchMulti(
    [init, help = {
      "title": "Title for the new to-do"}],
    [list],
    [edit, help = {
      "id": "ID of the to-do to edit",
      "title": "New title for the to-do"}],
    [done, help = {
      "id": "ID of the to-do to mark as done"}],
    [remove, help = {
      "id": "ID of the to-do to delete"}]
  )
