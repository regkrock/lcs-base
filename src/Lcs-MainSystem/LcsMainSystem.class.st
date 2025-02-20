Class {
	#name : #LcsMainSystem,
	#superclass : #LcsBaseSystem,
	#classVars : [
		'Singleton'
	],
	#category : #'Lcs-MainSystem'
}

{ #category : #'slot definitions' }
LcsMainSystem class >> configurationSlotDefinition [
	"<slotDefinition>
	^ LcsModuleConfigurationSlot newOn: LcsSystemConfiguration"
]

{ #category : #'slot model' }
LcsMainSystem >> systemDomainClasses [
	| collection |
	collection := super systemDomainClasses.
	self allSubmoduleClasses do: [ :eachModule | collection addAll: eachModule package classes ].
	collection addAll: self class package classes.
	^ collection
]
