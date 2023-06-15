class SomeClass
{
/**
* @var array|null
*/
var $property;

/**
* @return SomeClass
*/
function foo()
{
$x = eval('magic1()');
/** @var $x PDOStatement */
$x->query();

return eval('magic2()');
}
}