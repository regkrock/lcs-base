Class {
	#name : 'LuiComponentExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiComponentExamples >> newComponent [
	<gtExample>
	| component |
	component := LuiComponent new.
	self assert: (component class == LuiComponent).
	self assert: component components isEmpty.
	self assert: component properties hasNoProperties.
	self assert: component cssClassesString isEmpty.
	self assert: component properties hasProperties.
	self assert: (component properties isKindOf: LuiComponentProperties).
	self assert: component isVisible.
	self deny: component isHidden.
	self assert: component componentId isNil.
	self assert: component parentComponent isNil.
	self assert: component domainObject isNil.
	^ component
	
]

{ #category : 'examples' }
LuiComponentExamples >> visibilityPolicy [
	<gtExample>
	| component |
	component := self newComponent.
	component beHidden.
	self assert: component isHidden.
	self deny: component isVisible.
	component beVisible.
	self deny: component isHidden.
	self assert: component isVisible.
	^ component properties visibilityProperty
]

{ #category : 'examples' }
LuiComponentExamples >> visibilityPolicyInHiddenState [
	<gtExample>
	| component |
	component := self newComponent.
	component beHidden.
	self assert: component isHidden.
	self deny: component isVisible.
	^ component properties visibilityProperty
]

{ #category : 'examples' }
LuiComponentExamples >> visibilityPolicyInVisibleState [
	<gtExample>
	| component |
	component := self newComponent.
	self deny: component isHidden.
	self assert: component isVisible.
	^ component properties visibilityProperty
]
