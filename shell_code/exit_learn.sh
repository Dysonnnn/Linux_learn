function Fun()
{
	echo "world" >&2
	echo "WORLD"
	exit 2
}
res=$(Fun)


echo "Hello"
exit 2
echo "hello 2"
exit 0