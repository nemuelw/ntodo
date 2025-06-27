# ntodo

Minimal CLI to-do manager

## Setup

- Clone this repository

```nim
git clone https://github.com/nemuelw/ntodo.git
```

- Navigate to the project directory & install dependencies

```nim
cd ntodo
```

```nim
nimble install
```

- Build the program

```nim
nim c src/ntodo.nim
```

- You can now copy or move the generated binary (`ntodo`) wherever you wish to use it

## Usage

### Add new to-do item:

```bash
./ntodo init "Do my laundry"
```

### List to-dos

```bash
./ntodo list
```

### Edit to-do

```bash
./ntodo edit --id <todo Id> --title <new title>
```

### Mark to-do as done

```bash
./ntodo done --id <todo Id>
```

### Remove to-do from list

```bash
./ntodo remove --id <todo Id>
```

## Contributing

Contributions are welcome! Feel free to create an issue or open a pull request.

## License

This project is licensed under the terms of the [MIT License](https://opensource.org/licenses/MIT).
