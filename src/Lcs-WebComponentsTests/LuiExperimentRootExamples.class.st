Class {
	#name : 'LuiExperimentRootExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiExperimentRootExamples >> addSecondFormToRootWithStandardLayout [
	| experimentUI mainForm |
	<gtExample>
	experimentUI :=  self rootWithStandardLayout.
	experimentUI mainForm switchToComponent: (LuiHomePresenter named: 'contactsPresenter').
	mainForm := experimentUI mainForm.
	self assert:  mainForm currentSwitchableComponent componentName equals: 'contactsPresenter'.
	self assert: mainForm switchableComponents size equals: 2.
	self assert: (mainForm switchableComponentNamed: 'xxxx') isNil.
	self assert: (mainForm switchableComponentNamed: 'contactsPresenter') notNil.
	self assert: (mainForm switchableComponentNamed: 'contactsPresenter') identicalTo: mainForm currentSwitchableComponent.
	self assert: (mainForm switchableComponentNamed: 'homePresenter') notNil.
	^ experimentUI
]

{ #category : 'examples' }
LuiExperimentRootExamples >> rootWithStandardLayout [
	| experimentUI mainForm |
	<gtExample>
	experimentUI :=  LuiExperimentRoot new.
	self assert: experimentUI pageHeader notNil.
	self assert: experimentUI mainForm notNil.
	mainForm := experimentUI mainForm.
	self assert: mainForm currentSwitchableComponent notNil.
	self assert: mainForm currentSwitchableComponent componentName equals: 'homePresenter'.
	self assert: mainForm switchableComponents size equals: 1.
	self assert: (mainForm switchableComponentNamed: 'xxxx') isNil.
	self assert: (mainForm switchableComponentNamed: 'homePresenter') notNil.
	self assert: mainForm children size equals: 1.
	self assert: mainForm children includes: mainForm currentSwitchableComponent.
	^ experimentUI
]

{ #category : 'examples' }
LuiExperimentRootExamples >> switchBackToFirstForm [
	| experimentUI mainForm |
	<gtExample>
	experimentUI :=  self addSecondFormToRootWithStandardLayout.
	mainForm := experimentUI mainForm.
	self assert:  mainForm currentSwitchableComponent componentName equals: 'contactsPresenter'.
	mainForm switchToComponent: (mainForm switchableComponentNamed: 'homePresenter').
	mainForm := experimentUI mainForm.
	self assert:  mainForm currentSwitchableComponent componentName equals: 'homePresenter'.
	self assert: mainForm switchableComponents size equals: 2.
	self assert: (mainForm switchableComponentNamed: 'homePresenter') identicalTo: mainForm currentSwitchableComponent.
	self assert: (mainForm switchableComponentNamed: 'homePresenter') notNil.
	^ experimentUI
]
