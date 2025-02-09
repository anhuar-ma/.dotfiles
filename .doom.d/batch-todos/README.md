# Batch Todos

This project provides a script to generate todo list files for the next 10 days. Each todo list is created using a predefined template.

## Setup

1. Ensure you have Emacs and Org mode installed.
2. Clone this repository to your local machine.
3. Navigate to the project directory.

## Usage

To generate todo lists for the next 10 days, run the following command in Emacs:

```elisp
(load-file "src/create-todos.el")
(batch-create-todos)
```

This will create a todo list file for each of the next 10 days in the specified directory.

## License

This project is licensed under the MIT License. See the LICENSE file for details.