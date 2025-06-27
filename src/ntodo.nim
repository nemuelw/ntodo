import jsony, os

type
    TodoItem = object
      id: int
      item: string
      done: bool

const TodoFile = "todos.json"

proc load_todos(): seq[TodoItem] =
  if not fileExists(TodoFile):
    return @[]
  let raw = readFile(TodoFile)
  fromJson(raw, seq[TodoItem])

when isMainModule:
  echo("ntodo")
  let todos = load_todos()
  echo todos
