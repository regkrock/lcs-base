Class {
	#name : #CssVariable,
	#superclass : #CssObject,
	#instVars : [
		'cssPropertyValue',
		'declarations',
		'variableName',
		'variableValue'
	],
	#category : #'Lcs-Css'
}

{ #category : #'instance  creation' }
CssVariable class >> newName: aString value: aValue [
	^ self new 
		initializeName: aString value: aValue;
		yourself
]

{ #category : #example }
CssVariable >> backgroundColourExample [
	<gtExample>
	<noTest>
	| variable |
	variable := CssVariable newName: 'background' value: CssColor red.
	self assert: variable variableName = 'background'.
	self assert: variable prettyCssString equals: '$background: red'.
	^variable
]

{ #category : #'as yet unclassified' }
CssVariable >> baseColourExample [
	<gtExample>
	<noTest>
	| variable |
	variable := CssVariable new.
	variable
		variableName: 'black';
		variableValue: '#000'.
	self assert: variable variableName = 'black'.
	self assert: variable prettyCssString equals: '$black: #000'.
	^variable
]

{ #category : #example }
CssVariable >> darkBorderExample [
	<gtExample>
	<noTest>
	| variable |
	variable := CssVariable new.
	variable
		variableName: 'dark-border';
		variableValue: 'rgba($base-color, 0.88)'.
	self assert: variable variableName = 'dark-border'.
	self assert: variable prettyCssString equals: '$dark-border: rgba($base-color, 0.88)'.
	^variable
]

{ #category : #accessing }
CssVariable >> declarations [
	^ declarations
]

{ #category : #accessing }
CssVariable >> declarations: anObject [ 
	declarations := anObject
]

{ #category : #'gt - views' }
CssVariable >> gtViewSlotModelFor: aView [
	<gtView>
	"^ aView empty"
	^ aView columnedList
		title: 'CSS Variable';
		priority: 10;
		items: [ Array with: self ];
		column: 'Variable' text: [ :each | each prettyCssString ];"
		"column: 'Class' text: [ :each | each class name ];
		column: 'Defined In' text: [ :each | each domainClass name ];
		column: '' stencil: [ :each | BrButton new
										aptitude: BrGlamorousButtonWithLabelAptitude new;
										label: 'Remove';
										action: [ :aButton | self domainClass removeDomainSlotNamed: each slotName ]] width: 70; 
		actionUpdateButton;"
		"yourself
]

{ #category : #accessing }
CssVariable >> initialize [
	self declarations: OrderedCollection new
]

{ #category : #initialize }
CssVariable >> initializeName: aString value: aValue [ 
	self
		variableName: aString;
		variableValue: aValue
]

{ #category : #printing }
CssVariable >> prettyCssOn: aStream [ 
	aStream 
		nextPutAll: '$' , self variableName;
		nextPutAll: ': ';
		nextPutAll: self variableValue asString
]

{ #category : #accessing }
CssVariable >> variableName [
	^variableName
]

{ #category : #accessing }
CssVariable >> variableName: aString [
	variableName := aString
]

{ #category : #accessing }
CssVariable >> variableValue [
	^ variableValue
]

{ #category : #accessing }
CssVariable >> variableValue: anObject [
	variableValue := anObject
]
