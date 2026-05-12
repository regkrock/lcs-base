Class {
	#name : 'LuiComponentExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiComponentExamples >> componentAddedAfterComponentA [
	<gtExample>
	| component mewComponent |
	component := self componentWithThirdSubcomponentAddedLast.
	component addComponent: (mewComponent := LuiComponent named: 'c') after: (component componentNamed: 'a').
	self assert: (component componentKeys first = '0').
	self assert: ((component componentKeys at: 2) = 'a').
	self assert: ((component componentKeys at: 3) = 'c').
	self assert: (component components at: mewComponent componentName) equals: mewComponent.
	^ component
]

{ #category : 'examples' }
LuiComponentExamples >> componentAddedBeforeComponentA [
	<gtExample>
	| component mewComponent |
	component := self componentWithThirdSubcomponentAddedLast.
	component addComponent: (mewComponent := LuiComponent named: 'c') before: (component componentNamed: 'a').
	self assert: (component componentKeys first = '0').
	self assert: ((component componentKeys at: 2) = 'c').
	self assert: ((component componentKeys at: 3) = 'a').
	self assert: (component components at: mewComponent componentName) equals: mewComponent.
	^ component
]

{ #category : 'examples' }
LuiComponentExamples >> componentWithSubComponent [
	<gtExample>
	| component aComponent |
	component := self newComponent.
	component componentName: 'root'.
	component addComponent: (aComponent := LuiComponent named: 'a').
	self assert: component hasComponents.
	self assert: (component componentKeys includes: 'a').
	self assert: (component components at: aComponent componentName) equals: aComponent.
	^ component
]

{ #category : 'examples' }
LuiComponentExamples >> componentWithSubcomponentAddedFirst [
	<gtExample>
	| component mewComponent |
	component := self componentWithSubComponent.
	self assert: (component componentKeys first = 'a').
	component addFirstComponent: (mewComponent := LuiComponent named: '0').
	self assert: component hasComponents.
	self assert: (component componentKeys first = '0').
	self assert: (component componentKeys last = 'a').
	self assert: (component components at: mewComponent componentName) equals: mewComponent.
	^ component
]

{ #category : 'examples' }
LuiComponentExamples >> componentWithThirdSubcomponentAddedLast [
	<gtExample>
	| component mewComponent |
	component := self componentWithSubcomponentAddedFirst.
	component addComponent: (mewComponent := LuiComponent named: 'b').
	self assert: component hasComponents.
	self assert: (component componentKeys first = '0').
	self assert: (component componentKeys last = 'b').
	self assert: (component components at: mewComponent componentName) equals: mewComponent.
	^ component
]

{ #category : 'examples' }
LuiComponentExamples >> newComponent [
	<gtExample>
	| component |
	component := LuiComponent new.
	self assert: (component class == LuiComponent).
	self assert: component components isEmpty.
	self assert: component componentKeys isEmpty.
	self assert: component hasNoAttributes.
	self assert: component cssClassesString isEmpty.
	self assert: component hasAttributes.
	self assert: (component attributes isKindOf: LuiComponentAttributes).
	self assert: component isVisible.
	self deny: component isHidden.
	self assert: component componentId isNil.
	self assert: component parentComponent isNil.
	self assert: component domainObject isNil.
	^ component
]

{ #category : 'examples' }
LuiComponentExamples >> visibilityAttribute [
	<gtExample>
	| component |
	component := self newComponent.
	component beHidden.
	self assert: component isHidden.
	self deny: component isVisible.
	component beVisible.
	self deny: component isHidden.
	self assert: component isVisible.
	^ component attributes visibilityAttribute
]

{ #category : 'examples' }
LuiComponentExamples >> visibilityAttributesInHiddenState [
	<gtExample>
	| component |
	component := self newComponent.
	component beHidden.
	self assert: component isHidden.
	self deny: component isVisible.
	^ component attributes visibilityAttribute
]

{ #category : 'examples' }
LuiComponentExamples >> visibilityAttributesInVisibleState [
	<gtExample>
	| component |
	component := self newComponent.
	self deny: component isHidden.
	self assert: component isVisible.
	^ component attributes visibilityAttribute
]
