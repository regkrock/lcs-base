Class {
	#name : #LcsSlotDefinitionsBuilderJob,
	#superclass : #LcsCodeBuilderJob,
	#instVars : [
		'targetClassName',
		'targetPackageName',
		'slotBuilders'
	],
	#category : #'Lcs-SlotTools'
}

{ #category : #accessing }
LcsSlotDefinitionsBuilderJob >> addSlotBuilder: aSlotBuilderDefinition [
	"aSlotBuilderDefinition parent: self."
	self  slotBuilders add: aSlotBuilderDefinition
]

{ #category : #'job steps' }
LcsSlotDefinitionsBuilderJob >> buildJobSteps [
		self slotBuilders do: [ :each |
			each targetClassName: self targetClassName.
			"each targetPackageName: self targetPackageName" .
			each slotDefinitionMetodBuilderStep 
				slotDefinitionClass: each slotDefinitionClassName asClass;
				slotTypes: each slotTypes copy.
			self addJobStep: each ]
]

{ #category : #initialize }
LcsSlotDefinitionsBuilderJob >> initialize [
	super initialize.
	self slotBuilders: OrderedCollection new
]

{ #category : #accessing }
LcsSlotDefinitionsBuilderJob >> slotBuilders [
	^ slotBuilders
]

{ #category : #accessing }
LcsSlotDefinitionsBuilderJob >> slotBuilders: anObject [
	slotBuilders := anObject
]

{ #category : #accessing }
LcsSlotDefinitionsBuilderJob >> targetClass [
	^ self targetClassName asClass
]

{ #category : #accessing }
LcsSlotDefinitionsBuilderJob >> targetClassName [
	^ targetClassName
]

{ #category : #accessing }
LcsSlotDefinitionsBuilderJob >> targetClassName: anObject [
	targetClassName := anObject
]

{ #category : #accessing }
LcsSlotDefinitionsBuilderJob >> targetPackageName [
	^ targetPackageName
]

{ #category : #accessing }
LcsSlotDefinitionsBuilderJob >> targetPackageName: anObject [
	targetPackageName := anObject
]
