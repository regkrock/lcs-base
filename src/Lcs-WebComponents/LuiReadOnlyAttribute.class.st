Class {
	#name : 'LuiReadOnlyAttribute',
	#superclass : 'LuiComponentAttribute',
	#category : 'Lcs-WebComponents',
	#package : 'Lcs-WebComponents'
}

{ #category : 'generated method' }
LuiReadOnlyAttribute class >> attributeName [
	^ #readOnly
]

{ #category : 'generated method' }
LuiReadOnlyAttribute >> readOnly [
	^ self cachedValue
]

{ #category : 'generated method' }
LuiReadOnlyAttribute >> readOnly: anObject [
	^ self valueBlock: [ anObject ]
]

{ #category : 'generated method' }
LuiReadOnlyAttribute >> tagAttributeSetterSelector [
	^ #readOnly:
]
