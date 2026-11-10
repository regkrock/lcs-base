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
	experimentUI mainForm switchToForm: (LuiHomePresenter named: 'contactsPresenter').
	mainForm := experimentUI mainForm.
	self assert:  mainForm currentForm componentName equals: 'contactsPresenter'.
	self assert: mainForm activeForms size equals: 2.
	self assert: (mainForm activeFormNamed: 'xxxx') isNil.
	self assert: (mainForm activeFormNamed: 'contactsPresenter') notNil.
	self assert: (mainForm activeFormNamed: 'contactsPresenter') identicalTo: mainForm currentForm.
	self assert: (mainForm activeFormNamed: 'homePresenter') notNil.
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
	self assert: mainForm currentForm notNil.
	self assert: mainForm currentForm componentName equals: 'homePresenter'.
	self assert: mainForm activeForms size equals: 1.
	self assert: (mainForm activeFormNamed: 'xxxx') isNil.
	self assert: (mainForm activeFormNamed: 'homePresenter') notNil.
	self assert: mainForm children size equals: 1.
	self assert: mainForm children includes: mainForm currentFormComponent.
	self assert: mainForm currentFormComponent children includes: mainForm currentForm.
	^ experimentUI
]

{ #category : 'examples' }
LuiExperimentRootExamples >> switchBackToFirstForm [
	| experimentUI mainForm |
	<gtExample>
	experimentUI :=  self addSecondFormToRootWithStandardLayout.
	mainForm := experimentUI mainForm.
	mainForm switchToForm: (mainForm activeFormNamed: 'homePresenter').
	mainForm := experimentUI mainForm.
	self assert:  mainForm currentForm componentName equals: 'homePresenter'.
	self assert: mainForm activeForms size equals: 2.
	self assert: (mainForm activeFormNamed: 'homePresenter') identicalTo: mainForm currentForm.
	self assert: (mainForm activeFormNamed: 'homePresenter') notNil.
	^ experimentUI
]
