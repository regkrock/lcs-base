Class {
	#name : #LcsCodesLoader,
	#superclass : #LcsObjectLoader,
	#category : #'Lcs-DomainBase'
}

{ #category : #'as yet unclassified' }
LcsCodesLoader class >> initializeSlotModel [ 
	"Not part of the model"
]

{ #category : #configuration }
LcsCodesLoader >> data [
	^ ''
]

{ #category : #loading }
LcsCodesLoader >> load [
	self protoCodes do: [ :eachProtoCode | 
		self targetClass new
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
