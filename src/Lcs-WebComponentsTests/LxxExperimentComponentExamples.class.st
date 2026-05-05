Class {
	#name : 'LxxExperimentComponentExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LxxExperimentComponentExamples >> callbackOverridingNameAttributeError [
	<gtExample>
	| component |
	component := LxxExperimentComponent new.

	self
		assert: [ :html | html render: component ]
		gives: '<label for="lastName">Last Name</label><input name="1" value="Smith" type="text"/>'
	
]
