Class {
	#name : #LcsStandardCodeClassesBuilderJob,
	#superclass : #LcsCodeClassesBuilderJob,
	#instVars : [
		'codeInstances'
	],
	#category : #'Lcs-Tools'
}

{ #category : #'job steps' }
LcsStandardCodeClassesBuilderJob >> codeCollectionClassBuilder [
	^ self jobSteps at: 2
]

{ #category : #accessing }
LcsStandardCodeClassesBuilderJob >> codeInstances [
	^ codeInstances
]

{ #category : #accessing }
LcsStandardCodeClassesBuilderJob >> codeInstances: aCollection [
	codeInstances := aCollection
]

{ #category : #configuration }
LcsStandardCodeClassesBuilderJob >> codeRootName: aString [
	| codeSlotName codesSlotName codeClassName codesClassName |

	codeSlotName := self codeSlotNameFrom: aString.
	codesSlotName := codeSlotName asEnglishPlural.
	codeClassName := self classPrefix , aString.
	codesClassName := (self classPrefix , aString) asEnglishPlural.

	self codeSuperclassBuilder rootName: aString.
	self codeCollectionClassBuilder rootName: aString asEnglishPlural.
	"self codeSuperClassParentSlotDefinitionStep 
		targetClassName: codeClassName;
		collectionSlotName: codesSlotName."
	self globalCollectionSlotBuilder 
		slotClassName: codesClassName;
		slotName: codesSlotName.
	self memberOfSlotInDomainClassBuilder
		collectionSlotName: codesSlotName;
		slotName: codeSlotName
]

{ #category : #'job steps' }
LcsStandardCodeClassesBuilderJob >> codeSuperclassBuilder [
	^ self jobSteps at: 1
]

{ #category : #configuration }
LcsStandardCodeClassesBuilderJob >> codeSuperclassRootName: aString [ 
	self codeSuperclassBuilder rootName: aString.
	self memberOfSlotInDomainClassBuilder slotName: ((aString first asLowercase asString) , (aString copyFrom: 2 to: aString size))
]

{ #category : #tests }
LcsStandardCodeClassesBuilderJob >> createCodeInstances: aCollection [ 
	self codeInstances addAll: aCollection
]

{ #category : #'job steps' }
LcsStandardCodeClassesBuilderJob >> globalCollectionSlotBuilder [
	^ self jobSteps at: 3
]

{ #category : #accessing }
LcsStandardCodeClassesBuilderJob >> initialize [
	super initialize.
	self addCodeSuperClassBuilderStep.
	self addCodeCollectionClassBuilderStep.
	self addGlobalCollectionSlotDefinitionBuilderStep.
	self addMemberOfSlotInDomainClassBuilderStep.
	self codeInstances: OrderedCollection new
]

{ #category : #'job steps' }
LcsStandardCodeClassesBuilderJob >> memberOfSlotInDomainClassBuilder [
	^ self jobSteps at: 4
]
