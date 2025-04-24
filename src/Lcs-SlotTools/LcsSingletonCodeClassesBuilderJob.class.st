Class {
	#name : #LcsSingletonCodeClassesBuilderJob,
	#superclass : #LcsCodeClassesBuilderJob,
	#instVars : [
		'codeSubclassBuilders'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #builders }
LcsSingletonCodeClassesBuilderJob >> addCodeSubclassBuilders [
	self codeSubclassBuilders
		do: [ :eachBuilder | 
			self
				addJobStep: (eachBuilder
						targetSuperclassName: self newDomainClassName;
						targetPackageName: self targetPackageName;
						yourself) ]
]

{ #category : #configuration }
LcsSingletonCodeClassesBuilderJob >> addCodeSubclassWithRootNamed: aString [
	self addCodeSubclassWithRootNamed: aString with: [ :classBuilder | ]
]

{ #category : #command }
LcsSingletonCodeClassesBuilderJob >> buildJobSteps [
	self addJobStep: self codeClassBuilder.
	self addCodeSubclassBuilders.
	self addJobStep: self codeCollectionClassBuilder.
	self addJobStep: self globalCollectionReferenceSlotBuilder.
	self addJobStep: self codeGlobalCollectionSlotBuilder.
	self addMemberOfSlotBuilderForTargetClasses
]

{ #category : #builders }
LcsSingletonCodeClassesBuilderJob >> codeClassBuilder [
	^ super codeClassBuilder
		targetSuperclassName: 'LcsSingletonCode';
		yourself
]

{ #category : #builders }
LcsSingletonCodeClassesBuilderJob >> codeSubclassBuilderFor: aString [
	^ LcsSingletonCodeClassBuilder new
		rootName: aString;
		codeDescription: aString;
		newClassName: self classPrefix , aString;
		targetSuperclassName: self newDomainClassName;
		targetPackageName: self targetPackageName;
		yourself
]

{ #category : #accessing }
LcsSingletonCodeClassesBuilderJob >> codeSubclassBuilders [
	^ codeSubclassBuilders
]

{ #category : #accessing }
LcsSingletonCodeClassesBuilderJob >> codeSubclassBuilders: aCollection [
	codeSubclassBuilders := aCollection
]

{ #category : #initialize }
LcsSingletonCodeClassesBuilderJob >> initialize [
	super initialize.
	self codeSubclassBuilders: OrderedCollection new
]

{ #category : #'gt views' }
LcsSingletonCodeClassesBuilderJob >> overview [
	| collection |
	collection := OrderedCollection new.
	collection add: 'Superclass' -> 1 .
	
	^collection.
	
]

{ #category : #command }
LcsSingletonCodeClassesBuilderJob >> populateSlotModel [
	self globalCollectionSlotDefinitionStep populateSlotModel.
	self currentSystem currentUnitOfWork applyChanges.
	self singletonClassBuilders do: [ :eachStep | eachStep populateSlotModel ].
	self currentSystem currentUnitOfWork applyChanges
]

{ #category : #printing }
LcsSingletonCodeClassesBuilderJob >> printJobStreamDetailsOn: aStream [
	aStream
		nextPutAll: 'Create and populate classes related to ';
		nextPutAll: self newDomainClassName asString
]

{ #category : #builders }
LcsSingletonCodeClassesBuilderJob >> singletonClassBuilders [
	^ self jobSteps stepsWithClass: LcsSingletonCodeClassBuilder
]

{ #category : #command }
LcsSingletonCodeClassesBuilderJob >> verifyPopulateSlotModel [
	self assert: self targetGlobalCollection parent == self targetModule.
	self assert: self targetGlobalCollection collectionSize = self singletonClassBuilders size.
	self singletonClassBuilders
		do: [ :eachStep | 
			self assert: (self targetGlobalCollection findWithKey: eachStep codeName) notNil ].
	self assert: self targetGlobalCollection defaultInstance notNil
]
