"
This was creataed to generate multiple slot definitions. Is this still needed?
"
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

{ #category : #'job steps' }
LcsSlotDefinitionsBuilderJob >> addSlotBuilder: aSlotBuilder [
	self slotBuilders add: (
		aSlotBuilder
			targetClassName: self targetClassName;
			yourself)
]

{ #category : #'job steps' }
LcsSlotDefinitionsBuilderJob >> buildJobSteps [
	self slotBuilders do: [ :each |
		each targetClassName: self targetClassName.
		each targetPackageName: self targetPackageName.
		self addJobStep: each. ]
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
	^ [ self targetClassName asClass ] on: NotFound on: [ :s | s return: nil ]
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
