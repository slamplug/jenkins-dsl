def file = new File( System.getProperty("user.home") + "/.jenkins/jobs/job-builder/workspace/repositories.json" )
def jsonText = file.getText()
def repositories = new groovy.json.JsonSlurper().parseText( jsonText )

repositories.each {
  	def jobName = "${it.repository}"
	def scmUrl = "https://github.com/slamplug/${it.repository}"
	job(jobName) {
    	scm {
        	git(scmUrl)
    	}
   		triggers {
        	scm('*/15 * * * *')
    	}
    	steps {
        	gradle('test')
    	}
    }
}
