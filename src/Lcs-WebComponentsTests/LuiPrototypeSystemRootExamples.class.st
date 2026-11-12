Class {
	#name : 'LuiPrototypeSystemRootExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiPrototypeSystemRootExamples >> rootWithStandardLayout [
	| root mainForm |
	<gtExample>
	root :=  LuiPrototypeSystemRoot new.
	self assert: root pageHeader notNil.
	self assert: root mainForm notNil.
	mainForm := root mainForm.
	self assert: mainForm currentSwitchableComponent notNil.
	self assert: mainForm currentSwitchableComponent componentName equals: 'homePresenter'.
	self assert: mainForm switchableComponents size equals: 1.
	self assert: (mainForm switchableComponentNamed: 'xxxx') isNil.
	self assert: (mainForm switchableComponentNamed: 'homePresenter') notNil.
	self assert: mainForm children size equals: 1.
	self assert: mainForm children includes: mainForm currentSwitchableComponent.
	^ root
]
