Class {
	#name : 'LcsGreatBritainPostalCode',
	#superclass : 'LcsBasePostCode',
	#category : 'Lcs-Geography-Core',
	#package : 'Lcs-Geography',
	#tag : 'Core'
}

{ #category : 'slot definition\t' }
LcsGreatBritainPostalCode class >> codeSlotDefinition [
	<accessorSlotDefinition>
	^ super codeSlotDefinition
		prevalidationTransformBlock: [ :value :slot | value isString ifTrue: [ value asUppercase ] ifFalse: [ value ] ];
		yourself
]

{ #category : 'defaults' }
LcsGreatBritainPostalCode class >> localePostalCodeName [
	^'Post Code'
]

{ #category : 'defaults' }
LcsGreatBritainPostalCode class >> postalCodeRegex [
	^'([Gg][Ii][Rr] 0[Aa]{2})|((([A-Za-z][0-9]{1,2})|(([A-Za-z][A-Ha-hJ-Yj-y][0-9]{1,2})|(([A-Za-z][0-9][A-Za-z])|([A-Za-z][A-Ha-hJ-Yj-y][0-9]?[A-Za-z])))) [0-9][A-Za-z]{2})'
]

{ #category : 'defaults' }
LcsGreatBritainPostalCode class >> postalCodeTooltip [
	^'ex: SY10 7LT'
]
