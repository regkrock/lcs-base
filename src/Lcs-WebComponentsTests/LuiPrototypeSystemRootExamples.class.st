Class {
	#name : 'LuiPrototypeSystemRootExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiPrototypeSystemRootExamples >> rootWithStandardLayout [
	| root mainForm menuItem |
	<gtExample>
	root :=  LuiPrototypeSystemRoot new.
	self assert: root rootComponent identicalTo: root.
	self assert: root pageHeader notNil.
	self assert: root mainForm notNil.
	mainForm := root mainForm.
	menuItem := root pageHeader navigationBar.
	^ root
]
