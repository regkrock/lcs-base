Class {
	#name : 'LcsCanadaPostalCode',
	#superclass : 'LcsBasePostCode',
	#category : 'Lcs-Geography-Core',
	#package : 'Lcs-Geography',
	#tag : 'Core'
}

{ #category : 'slot definition\t' }
LcsCanadaPostalCode class >> codeSlotDefinition [
	<accessorSlotDefinition>
	^ super codeSlotDefinition
		prevalidationTransformBlock: [ :value :slot | value isString ifTrue: [ value asUppercase ] ifFalse: [ value ] ];
		yourself
]

{ #category : 'defaults' }
LcsCanadaPostalCode class >> localePostalCodeName [
	^'Postal Code'
]

{ #category : 'defaults' }
LcsCanadaPostalCode class >> postalCodeRegex [
	^'[A-Za-z]\d[A-Za-z] \d[A-Za-z]\d'
]

{ #category : 'defaults' }
LcsCanadaPostalCode class >> postalCodeTooltip [
	^'A1A 1A1'
]
