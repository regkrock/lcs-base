Class {
	#name : 'LcsZipCode',
	#superclass : 'LcsBasePostCode',
	#category : 'Lcs-Geography-Core',
	#package : 'Lcs-Geography',
	#tag : 'Core'
}

{ #category : 'slot definition\t' }
LcsZipCode class >> codeSlotDefinition [
	<accessorSlotDefinition>
	^ super codeSlotDefinition
]

{ #category : 'defaults' }
LcsZipCode class >> localePostalCodeName [
	^'Zip Code'
]

{ #category : 'defaults' }
LcsZipCode class >> postalCodeRegex [
	"^'\d{5}'"
	^'[0-9]{5}(\-[0-9]{4})*'
]

{ #category : 'defaults' }
LcsZipCode class >> postalCodeTooltip [
	^'00000 or 00000-0000'
]
