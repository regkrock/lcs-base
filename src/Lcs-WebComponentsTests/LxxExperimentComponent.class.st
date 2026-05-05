Class {
	#name : 'LxxExperimentComponent',
	#superclass : 'WAComponent',
	#category : 'Lcs-WebComponentsTests-Experiment',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Experiment'
}

{ #category : 'as yet unclassified' }
LxxExperimentComponent >> renderContentOn: html [

	html label
		for: 'lastName';
		with: 'Last Name'.
	html textInput
		name: 'lastName';
		callback: [ :v | ];
		with: 'Smith'
]
