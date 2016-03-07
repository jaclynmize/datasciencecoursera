corr <- function(directory, threshold=0){

	final <- vector()
	id <- 1:332
	
	for(i in 1:length(id)){

	name <- paste0("raw_data", id[i])
	assign("name", read.csv(paste0(directory,"/", sprintf("%03d", id[i]), '.csv'), header=TRUE, stringsAsFactor = FALSE))

	if(sum(complete.cases(name)) > threshold){
		
		name2 <- name[complete.cases(name),]
		correlation <- cor(name2$sulfate, name2$nitrate)

	}else{correlation <- vector()}

	final <- c(final, correlation)
	
	}

	print(final)

}
