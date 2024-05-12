Class {
	#name : #LcsSlotModelDiagramExamples,
	#superclass : #LcsObject,
	#category : #'Lcs-Examples'
}

{ #category : #accessing }
LcsSlotModelDiagramExamples class >> openDomainClassSlotModel [
	<gtExample>
	^self new domainClassSlotModel
]

{ #category : #accessing }
LcsSlotModelDiagramExamples >> domainClassSlotModel [
	<gtExample>
	| model classes associations positions |

	classes := self domainSlotModelClasses.
	associations := self slotModelAssociationsWithLabels.
	positions := self domainClassSlotModelExplicitPositions.

	model := UmlClassDiagram new
		classHierarchyFor: classes
		withAssociationsAndLabels: associations.
		
	model layout custom: BlBasicLayout new.

	model root children withIndexDo: [ :child :n | child relocate: (positions at: n) ].
	
	^ model


]

{ #category : #accessing }
LcsSlotModelDiagramExamples >> domainClassSlotModelExplicitPositions [
	" (self root children collect: #position) storeString "

	^ (Array new: 41)
		at: 1 put: 31.0 @ 27.0;
		at: 2 put: 32.0 @ -55.0;
		at: 3 put: 26.0 @ -164.0;
		at: 4 put: 50.0 @ -243.0;
		at: 5 put: 276.0 @ 34.0;
		at: 6 put: -171.0 @ 78.0;
		at: 7 put: -171.0 @ -166.0;
		at: 8 put: 82.6396945904722 @ -25.40216064453122;
		at: 9 put: 84.00257685302583 @ -134.40216064453125;
		at: 10 put: 84.6108856886328 @ -213.40216064453125;
		at: 11 put: 99.22774561452863 @ -213.40216064453125;
		at: 12 put: -125.53470565501905 @ -136.40216064453125;
		at: 13 put: -85.01215692576133 @ -215.26867150379852;
		at: 14 put: 133.70800781250003 @ 16.623735377146943;
		at: 15 put: 133.70800781250003 @ 16.623735377146943;
		at: 16 put: 133.70800781250003 @ 16.623735377146943;
		at: 17 put: 133.70800781250003 @ 16.623735377146943;
		at: 18 put: 133.70800781250003 @ 16.623735377146943;
		at: 19 put: 133.70800781250003 @ 16.623735377146943;
		at: 20 put: 133.70800781250003 @ 16.623735377146943;
		at: 21 put: 133.70800781250003 @ 43.175296752118584;
		at: 22 put: 133.70800781250003 @ 43.175296752118584;
		at: 23 put: 133.70800781250003 @ 43.175296752118584;
		at: 24 put: 133.70800781250003 @ 43.175296752118584;
		at: 25 put: 133.70800781250003 @ 43.175296752118584;
		at: 26 put: 133.70800781250003 @ 43.175296752118584;
		at: 27 put: 133.70800781250003 @ 43.175296752118584;
		at: 28 put: -112.24037251595843 @ -134.40216064453125;
		at: 29 put: -112.24037251595843 @ -134.40216064453125;
		at: 30 put: -112.24037251595843 @ -134.40216064453125;
		at: 31 put: -112.24037251595843 @ -134.40216064453125;
		at: 32 put: -112.24037251595843 @ -134.40216064453125;
		at: 33 put: -112.24037251595843 @ -134.40216064453125;
		at: 34 put: -112.24037251595843 @ -134.40216064453125;
		at: 35 put: -79.0999984741211 @ 55.14011562503299;
		at: 36 put: -79.0999984741211 @ 55.14011562503299;
		at: 37 put: -79.0999984741211 @ 55.14011562503299;
		at: 38 put: -79.0999984741211 @ 55.14011562503299;
		at: 39 put: -79.0999984741211 @ 55.14011562503299;
		at: 40 put: -79.0999984741211 @ 55.14011562503299;
		at: 41 put: -79.0999984741211 @ 55.14011562503299;
		yourself
]

{ #category : #accessing }
LcsSlotModelDiagramExamples >> domainSlotModelClasses [
	| classes |
	classes := OrderedCollection new
			add: LcsBaseSystem;
			addAll: LcsBaseSystem allSuperclasses;
			add: LcsSystemSlotModel;
			add: LcsSlotModel;
			addAll: LcsSlotModel allSuperclasses;
			yourself.
	classes removeDuplicates.
	classes remove: Object.
	([ 'ProtoObject' asClass ] on: NotFound do: [ nil ])
		ifNotNil: [ :class | classes remove: class ifAbsent: [  ] ].
	^ classes
]

{ #category : #accessing }
LcsSlotModelDiagramExamples >> slotDefinitionsHierarchy [
	<gtExample>
	^ UmlClassDiagram new classHierarchyFor: LcsSlotDefintion withAllSubclasses
]

{ #category : #accessing }
LcsSlotModelDiagramExamples >> slotModelAssociationsWithLabels [
	^ {LcsBaseSystem
			-> {{'systemSlotModel'.
						LcsSystemSlotModel}}.
		LcsSystemSlotModel
			-> {{'parent'.
						LcsBaseSystem}}.
		LcsDomainObject
			-> {{'slotModel'.
						LcsSlotModel}}.
		LcsSystemSlotModel
			-> {{'slotModels'.
						LcsSlotModel}}}
]
