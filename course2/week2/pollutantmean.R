pollutantmean <- function(directory, pollutant, id = 1:332){

	all_data <- data.frame()
	
	for(i in 1:length(id)){

	name <- paste0("raw_data", id[i])
	assign("name", read.csv(paste0(directory,"/", sprintf("%03d", id[i]), '.csv'), header=TRUE, stringsAsFactor = FALSE))
	all_data <- rbind(all_data, name)
	number <- which( colnames(all_data)==pollutant ) 
	all_data2 <- all_data[, c(number)]
	all_data3 <- data.frame(all_data2)
	all_data4 <- all_data3[complete.cases(all_data3),]

	}

	mean(all_data4)

}
