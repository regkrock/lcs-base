Class {
	#name : 'LuiPageHeaderExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'as yet unclassified' }
LuiPageHeaderExamples >> exampleHeader [
	<gtExample>
	| header |
	header := self newComponent.
	header 
		cssClass: 'topHeader';
		addComponent: LuiNavigationBarExamples new exampleNavigationBar;
		addComponent: LuiSearchAndSocialMediaBar newSearchAndLinks.
	^ header
]

{ #category : 'examples' }
LuiPageHeaderExamples >> htmlForNewComponent [
	<gtExample>
	^ self assertRenderNewComponentEquals:'<header name="pageHeader" data-StClass="LuiPageHeader" class="pageHeader"></header>'
]

{ #category : 'as yet unclassified' }
LuiPageHeaderExamples >> newComponent [
	<gtExample>
	| component |
	component := LuiPageHeader named: 'pageHeader'.	
	self assert: component componentName = 'pageHeader'.
	self assert: component hasNoComponents.
	^ component
]
