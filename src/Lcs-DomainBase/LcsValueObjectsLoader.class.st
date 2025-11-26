Class {
	#name : 'LcsValueObjectsLoader',
	#superclass : 'LcsObjectsLoader',
	#category : 'Lcs-DomainBase-Loader',
	#package : 'Lcs-DomainBase',
	#tag : 'Loader'
}

{ #category : 'configuration' }
LcsValueObjectsLoader >> data [
	^ ''
]

{ #category : 'loading' }
LcsValueObjectsLoader >> loadInto: aTargetCollection [
	| newClass instance|
	self protoCodes do: [ :eachProtoCode | 
		newClass := (eachProtoCode code = 'unknown' and: [ self unknownClass notNil ])
			ifTrue: [ self unknownClass ]
			ifFalse: [ self targetClass ].
		instance := newClass new
			code: eachProtoCode code;
			description: eachProtoCode description;
			label: eachProtoCode label;
			isDefaultInstance: eachProtoCode isDefaultInstance.
		aTargetCollection add: instance ]
]

{ #category : 'data' }
LcsValueObjectsLoader >> protoCodes [
	^ (NeoJSONReader on: self data readStream)
			mapInstVarsFor: LcsProtoCode;
			for: #ArrayOfPrtotCodes customDo: [ :mapping | mapping listOfElementSchema: LcsProtoCode ];
			nextAs: #ArrayOfPrtotCodes.
]

{ #category : 'configuration' }
LcsValueObjectsLoader >> targetClass [
	^ self subclassResponsibility
]

{ #category : 'configuration' }
LcsValueObjectsLoader >> unknownClass [
	^ nil
]
