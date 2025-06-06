Class {
	#name : #LcsValueObjectsLoader,
	#superclass : #LcsObjectLoader,
	#category : #'Lcs-DomainBase'
}

{ #category : #configuration }
LcsValueObjectsLoader >> data [
	^ ''
]

{ #category : #loading }
LcsValueObjectsLoader >> load [
	| newClass |
	self protoCodes do: [ :eachProtoCode | 
		newClass := (eachProtoCode code = 'unknown' and: [ self unknownClass notNil ])
			ifTrue: [ self unknownClass ]
			ifFalse: [ self targetClass ].
		newClass new
			code: eachProtoCode code;
			description: eachProtoCode description;
			label: eachProtoCode label;
			isDefaultInstance: eachProtoCode isDefaultInstance ]
]

{ #category : #loading }
LcsValueObjectsLoader >> protoCodes [
	^ (NeoJSONReader on: self data readStream)
			mapInstVarsFor: LcsProtoCode;
			for: #ArrayOfPrtotCodes customDo: [ :mapping | mapping listOfElementSchema: LcsProtoCode ];
			nextAs: #ArrayOfPrtotCodes.
]

{ #category : #configuration }
LcsValueObjectsLoader >> targetClass [
	^ self subclassResponsibility
]

{ #category : #configuration }
LcsValueObjectsLoader >> unknownClass [
	^ nil
]
