# multitypes-multivalues
When you need a function param that accepts type or type value f.e. integer or String - nothing else. The values are carried by container class and types errors are compile time or in editor ones.

In short just a dart file condition_multi_types.dart contains three classess with examples. It is recommended that you use Types<V, W> class for two optional types (the class contains one type value of two types given in generic), or Types3<V, W, U> for three optional types. You can use MTypes<V, W> for two or three types but this class is a bit more resources draining so use it for more than 3 optional types, because the Types class is totally simple and by this should be like natively fast. 
