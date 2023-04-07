

///common
///
/// <pre>
///     author : szyc
///     e-mail : szyc
///     time   : 2019/11/7 3:14 PM
///     desc   : 
///     version: 1.0
/// </pre>
///
class KeyValue extends CheckPathBean{
   String key;
   dynamic value;

   KeyValue(this.key, this.value);
}

class CheckPathBean{
   bool isCheck = true;
   String imgPath;
}