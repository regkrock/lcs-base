Class {
	#name : 'LcsStringSlot',
	#superclass : 'LcsBaseSmalltalkObjectSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'magritte' }
LcsStringSlot >> allowEmptyIntialValueDescription [
	"<magritteDescription>"
	^ MABooleanDescription new
		label: 'Allow Empty';
		priority: 10;
		accessor: #allowEmptyIntialValue;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired
]

{ #category : 'configuration' }
LcsStringSlot >> beAllowInitialNull [
	self beAllowNull.
	(self validationRules hasRuleWithDescription: LcsAllowInitialNullRule new description)
		ifFalse: [self validationRules addFirstRule: (LcsAllowInitialNullRule new) ]
]

{ #category : 'configuration' }
LcsStringSlot >> beDisallowInitialNull [
	self allowNull.
	(self validationRules hasRulerNamed: LcsAllowInitialNullRule new description)
		ifFalse: [self validationRules addFirstRule: (LcsAllowInitialNullRule new) ]
]

{ #category : 'defaults' }
LcsStringSlot >> defaultInitialValueBlock [
	^ [ :parentDomainObject :slot | self typeClass new ]
]

{ #category : 'default ui component' }
LcsStringSlot >> defaultInputComponentClassName [
	^#LuiTextInput
]

{ #category : 'iniitialize' }
LcsStringSlot >> initialValue: anObject [
	super initialValue:anObject printString
]

{ #category : 'testing' }
LcsStringSlot >> isNullObject: anObject [ 
	^ anObject isString and: [ anObject isEmpty ]
]

{ #category : 'configuration' }
LcsStringSlot >> typeClass [
	<todo: 'This needs to use UTF-8 string calss'> 
	^ LcsSmalltalkConfiguration stringClass
]
