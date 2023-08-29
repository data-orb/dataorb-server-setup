## Jenkins Configuration

### Structure

Create directories:

<pre>
/ebs1/jenkins/workspace
/ebs1/jenkins/builds
/ebs1/maven/repository
</pre>

### Server setup

Increase available memory and relax content security policy by adding system property:

<pre>
sudo nano /etc/default/jenkins
JAVA_ARGS="-Xmx10000m -Djava.awt.headless=true -Dhudson.model.DirectoryBrowserSupport.CSP="
</pre>

### Plugins

Install plugins:

- Bazaar
- Maven integration

### Configure Jenkins

<pre>
Jenkins > Manage Jenkins > Configure System
</pre>

Property | Value
--- | ---
Workspace Root Directory | /ebs1/jenkins/workspace/${ITEM_FULLNAME}
Build Record Root Directory | /ebs1/jenkins/builds/${ITEM_FULLNAME}
Local Maven Repository | Local to the workspace
Jenkins URL | http://ci.dataorb.co
System Admin e-mail address | ci@dataorb.co
SMTP server | email-smtp.eu-west-1.amazonaws.com
Use SMTP Authentication | Yes (Use AWS SES credentials)
Use SSL | No
SMTP Port | 25
Reply-To Address | ci@dataorb.co

### Configure WAR Job

<pre>
Jenkins > New item > Maven project
</pre>

Property | Value
--- | ---
Maven project name | dataorb-*
Discard old builds | Yes
Max # of builds to keep | 1
Source Code Management | Bazaar
Repository URL | lp:dataorb
Poll SCM Schedule | */30 * * * *
Root POM | dataorb/pom-full.xml
Goals and options | clean install --update-snapshots
E-mail Notification | Yes
Recipients | ci@dataorb.co
Add post build action | Archive the artefacts
Files to archive | dataorb/dlms-web/dlms-web-portal/target/dlms.war

### Configure Javadoc Job

Same as above except:

Property | Value
--- | ---
Root POM | dataorb/pom.xml
Goals and options | clean javadoc:aggregate -DskipTests=true

### Configure Maven

Create maven settings file:

<pre>/var/lib/jenkins/.m2/settings.xml</pre>

<pre>
&lt;settings&gt;
  &lt;localRepository&gt;/ebs1/maven/repository&lt;/localRepository&gt;
&lt;/settings&gt;
</pre>

