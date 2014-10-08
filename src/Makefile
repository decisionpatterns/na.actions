

VERSION=1.7-11

default: zoo
	cp zoo/R/na.* ../R/
	



zoo: 
	wget http://cran.r-project.org/src/contrib/zoo_$(VERSION).tar.gz
	tar -xvf zoo_$(VERSION).tar.gz
	Rscript -e 'library(Rd2roxygen);Rd2roxygen("zoo")'
	

	
