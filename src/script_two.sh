function private_print() {
  echo "Private function only available to this script."
} 

function private_print_two() {
  echo "Private function only available to this script."
} 

print_foo "foo"
print_bar "bar"
private_print
private_print_two