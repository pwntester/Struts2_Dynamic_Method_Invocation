This is the example project that demonstrates a security vulnerability in the 
Struts 2 framework when <constant name="struts.enable.DynamicMethodInvocation" value="false" />
is not included in struts.xml or struts.properties.

To build the application's war file run mvn clean package
from the project's root folder.

The war file is created in the target sub-folder.

Copy the war file to your Servlet container (e.g. Tomcat, GlassFish) and 
then startup the Servlet container.

In a web browser go to:  http://localhost:8080/struts2_security_vulnerability/index.action.

You should see a web page with Welcome to Struts 2!

By default dynamic method invocation is allowed.  Dynamic method invocation allows the 
use of the bang (!) operator followed by a method name in the URL.  For more information about 
dynamic method invocation see:

http://struts.apache.org/2.2.1.1/docs/action-configuration.html#ActionConfiguration-DynamicMethodInvocation

For example if the ActionSupport class has a public method called getPassword, 
then that method could be called by the web application user by entering this URL 
in the browser:

http://localhost:8080/struts2_security_vulnerability/recoverpassword!getPassword.action

The String returned by the method getCurrentPassword will be displayed in the error message 
the user's sees.  Note that recoverpassword must be matched to an ActionSupport class
that has a public getPassword method that has no parameters.

The result of the url:

http://localhost:8080/struts2_security_vulnerability/recoverpassword!getPassword.action

will either be a 404 error or a stack trace if the struts devmode is true.

The 404 error page will include this line:

No result defined for action edu.ku.it.si.struts2securityvulnerability.security.action.RecoverPassword 
and result user_secrect_password

The last part is the String returned by method getPassword, which in this 
example is the user's password.

The stack trace will include a similar line that exposes the user's password.

Any public method in the ActionSupport class that has no parameters is vulnerable, even 
if the method returns no value.  For example enter this URL in the example application:

http://localhost:8080/struts2_security_vulnerability/changepassword!changePassword.action?newPassword=my_new_password&username=bruce

The above URL will cause method changePassword to be executed (see class ChangePassword ) and the password for user bruce
will be changed to my_new_password.  This URL completely bypassed the authentication check in the execute method of 
class ChangePassword.

How To Fix The DynamicMethodInvocation Security Vulnerability

Include in struts.xml this Struts 2 property setting:

constant name="struts.enable.DynamicMethodInvocation" value="false" />

or in struts.properties:

struts.enable.DynamicMethodInvocation = false


(In the example application's struts.xml uncomment that property setting to fix the problem in
the example.)

The above setting will prevent Struts 2 from parsing the bang operator (!) in the URL, so then the whole
part before .action will be used to match to a configured Struts 2 action.  For example with this URL

http://localhost:8080/struts2_security_vulnerability/recoverpassword!getPassword.action

instead of method getPassword being called on the ActionSupport class matched to recoverpassword, the 
Struts 2 framework will try to find an action named recoverpassword!getPassword.action (which won't exist).

Good Practices To Follow When Designing Struts 2 ActionSupport classes

1.  The only methods that should be public are the execute, input, validate and get/set methods for the instance fields 
that are exposed to the view pages.

2.  All methods that do some work on behalf of the action should be in a Service layer class and not in the 
ActionSupport class.






