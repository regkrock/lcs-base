Class {
	#name : #LxxExperimentComponent,
	#superclass : #WAComponent,
	#category : #'Lcs-WebComponentsTests-Tests'
}

{ #category : #private }
LxxExperimentComponent >> assert: aBlock gives: aString [
	| html |
	html := WAHtmlCanvas builder
		fullDocument: false;
		rootBlock: aBlock;
		render: aBlock.
	self assert: aString equals: html
]

{ #category : #'as yet unclassified' }
LxxExperimentComponent >> renderContentOn: html [

	html label
		for: 'lastName';
		with: 'Last Name'.
	html textInput
		name: 'lastName';
		callback: [ :v | ];
		with: 'Smith'
]
