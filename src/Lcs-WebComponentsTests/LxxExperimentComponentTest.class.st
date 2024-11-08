Class {
	#name : #LxxExperimentComponentTest,
	#superclass : #TestCase,
	#category : #'Lcs-WebComponentsTests-Tests'
}

{ #category : #'as yet unclassified' }
LxxExperimentComponentTest >> assert: aBlock gives: aString [
	| html |
	html := WAHtmlCanvas builder
		fullDocument: false;
		rootBlock: aBlock;
		render: aBlock.
	self assert: aString equals: html
]

{ #category : #'as yet unclassified' }
LxxExperimentComponentTest >> testCallbackOverridingNameAttributeError [
	| component |
	component := LxxExperimentComponent new.
	
	"This will fail because the name will be 1, not lastName. This is because the callback 
	 block overrides the name attribute"
	 
	self
		assert: [ :html | html render: component ]
		gives: '<label for="lastName">Last Name</label><input name="lastName" value="Smith" type="text"/>'
	
]
