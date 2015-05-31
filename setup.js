!function(e,t){function n(){if(t.XMLHttpRequest)return new t.XMLHttpRequest;try{return new t.ActiveXObject("MSXML2.XMLHTTP.3.0")}catch(e){}throw new Error("no xmlhttp request able to be created")}function r(e,t,n){e[t]=e[t]||n}t.nanoajax=e,e.ajax=function(e,t){"string"==typeof e&&(e={url:e});var a=e.headers||{},o=e.body,u=e.method||(o?"POST":"GET"),i=e.withCredentials||!1,s=n();s.withCredentials=i,s.onreadystatechange=function(){4==s.readyState&&t(s.status,s.responseText,s)},o&&(r(a,"X-Requested-With","XMLHttpRequest"),r(a,"Content-Type","application/x-www-form-urlencoded")),s.open(u,e.url,!0);for(var c in a)s.setRequestHeader(c,a[c]);s.send(o)}}({},function(){return this}());
var d,_=function(n){return document.getElementById(n);},r=_("radio"),v="innerHTML";
function f(s){_("fail").style.display="block";r[v]='<b>'+s+'</b>';}
function w(s){r[v]=s;}
function k(s,i){_("ok").style.display="block";r[v]=s;_("ip")[v] = i;window.clearInterval(d)}
var s=["idle","connecting","wrong password","no AP found","fail","got ip"];
var t=[w,w,f,f,f,k];
function poll(){nanoajax.ajax('/test',function(c,y){var o=JSON.parse(y);t[o.status](s[o.status],o.ip);});}
d=window.setInterval(poll, 500)