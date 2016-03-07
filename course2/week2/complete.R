complete <- function(directory, id = 1:332){

	final <- data.frame()
	
	for(i in 1:length(id)){

	name <- paste0("raw_data", id[i])
	assign("name", read.csv(paste0(directory,"/", sprintf("%03d", id[i]), '.csv'), header=TRUE, stringsAsFactor = FALSE))

	nobs <- sum(complete.cases(name))
	ids <- id[i]

	data <- data.frame(ids, nobs)
	colnames(data) <- c("id","nobs")
	final <- rbind(final, data)
	colnames(final) <- c("id","nobs")

	}

	print(final)

}
