Class {
	#name : 'LcsBasePostCode',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'code'
	],
	#category : 'Lcs-Geography-Core',
	#package : 'Lcs-Geography',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsBasePostCode class >> codeSlotDefinition [
	<accessorSlotDefinition>
	| slotDefinition |
	slotDefinition := LcsStringSlot new.
	slotDefinition
		slotName: 'code';
		beAllowInitialNull.
	self postalCodeRegex ifNotNil: [ 
		slotDefinition
			pattern: self postalCodeRegex;
			tooltip: self postalCodeTooltip;
			beRequired;
			addValidationRuleBlock: [ :value :parentDomainObject :oldValue | 
					value matchesRegex: slotDefinition pattern ]
				description: 'Postal Code Verification'
				errorMessage: self postalCodeErrorMessage ].
	^ slotDefinition
]

{ #category : 'defaults' }
LcsBasePostCode class >> localePostalCodeName [
	self subclassResponsibility
]

{ #category : 'defaults' }
LcsBasePostCode class >> postalCodeErrorMessage [
	^ self localePostalCodeName , ' must be of form ' , self postalCodeTooltip
]

{ #category : 'defaults' }
LcsBasePostCode class >> postalCodeRegex [
	^ nil
]

{ #category : 'defaults' }
LcsBasePostCode class >> postalCodeTooltip [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
LcsBasePostCode >> code [
	^ self slotVarNamed: 'code'
]

{ #category : 'accessing' }
LcsBasePostCode >> code: anObject [
	self slotVarNamed: 'code' put: anObject
]

{ #category : 'printing' }
LcsBasePostCode >> gtDisplayOn: stream [
	self gtPrint: self code on: stream
]
