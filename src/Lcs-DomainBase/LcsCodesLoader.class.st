Class {
	#name : #LcsCodesLoader,
	#superclass : #LcsObjectLoader,
	#category : #'Lcs-DomainBase'
}

{ #category : #configuration }
LcsCodesLoader >> data [
	^ ''
]

{ #category : #loading }
LcsCodesLoader >> load [
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
LcsCodesLoader >> protoCodes [
	^ (NeoJSONReader on: self data readStream)
			mapInstVarsFor: LcsProtoCode;
			for: #ArrayOfPrtotCodes customDo: [ :mapping | mapping listOfElementSchema: LcsProtoCode ];
			nextAs: #ArrayOfPrtotCodes.
]

{ #category : #configuration }
LcsCodesLoader >> targetClass [
	^ self subclassResponsibility
]

{ #category : #configuration }
LcsCodesLoader >> unknownClass [
	^ nil
]
