Class {
	#name : 'LuiSmalltalkObjectAccessorExamples',
	#superclass : 'LuiSeasideComponentExamples',
	#category : 'Lcs-WebComponentsTests-Examples',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LuiSmalltalkObjectAccessorExamples >> newAccessor [
	<gtExample>
	| accessor |
	accessor := LuiSmalltalkObjectAccessor new.
	self assert: accessor model isNil.
	self assert: accessor readSelector equals: #yourself.
	self assert: accessor writeSelector equals: #yourself.
	self assert: accessor contents isNil.
	self assert: accessor displayValue equals: 'nil'.
	accessor write: true.
	self assert: accessor model equals: true.
	self assert: accessor contents equals: true.
	self assert: accessor displayValue equals: 'true'.
	^ accessor
]

{ #category : 'examples' }
LuiSmalltalkObjectAccessorExamples >> newAccessorWithBooleanModel [
	<gtExample>
	| accessor component model |
	model := true.
	component := LuiCheckbox new.
	accessor := LuiSmalltalkObjectAccessor newOn: component model: model.
	self assert: accessor model == model.
	self assert: accessor readSelector equals: #yourself.
	self assert: accessor writeSelector equals: #yourself.
	self assert: accessor contents == true.
	self assert: accessor displayValue equals: 'true'.
	accessor write: false.
	self assert: accessor read equals: false.
	self assert: accessor contents equals: false.
	self assert: accessor displayValue equals: 'false'.
	^ accessor
]

{ #category : 'examples' }
LuiSmalltalkObjectAccessorExamples >> newAccessorWithFooModel [
	<gtExample>
	| accessor component model |
	model := LxxFoo newBar: true.
	component := LuiCheckbox new.
	accessor := LuiSmalltalkObjectAccessor newOn: component selector: #bar model: model.
	self assert: accessor model == model.
	self assert: accessor readSelector equals: #bar.
	self assert: accessor writeSelector equals: #bar:.
	self assert: accessor contents == true.
	self assert: accessor displayValue equals: 'true'.
	accessor write: false.
	self assert: accessor read equals: false.
	self assert: accessor contents equals: false.
	self assert: accessor displayValue equals: 'false'.
	^ accessor
]
