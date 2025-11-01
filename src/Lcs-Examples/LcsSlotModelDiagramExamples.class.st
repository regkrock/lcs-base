Class {
	#name : #LcsSlotModelDiagramExamples,
	#superclass : #LcsObjectExamples,
	#category : #'Lcs-Examples'
}

{ #category : #example }
LcsSlotModelDiagramExamples >> domainObjectSlotModel [
	<gtExample>
	| model classes associations positions |

	classes := self domainObjectSlotModelClasses.
	associations := self domainObjectSlotModelAssociationsWithLabels.
	positions := self domainObjectSlotModelExplicitPositions.

	model := UmlClassDiagram new
		classHierarchyFor: classes
		withAssociationsAndLabels: associations.
		
	model layout custom: BlBasicLayout new.

	model root children withIndexDo: [ :child :n | child relocate: (positions at: n) ].
	
	^ model


]

{ #category : #private }
LcsSlotModelDiagramExamples >> domainObjectSlotModelAssociationsWithLabels [
	^ {LcsSlotModel
			-> {{'slotDefintions'.
						LcsAccessorSlot}}.
		LcsAccessorSlot
			-> {{'parent'.
						LcsSlotModel}.
					{'domainClass'.
						LcsBaseDomainObject}}.
		LcsBaseDomainObject
			-> {{'slotModel'.
						LcsSlotModel}}.
		LcsSlotModel
			-> {{'domainClass'.
						LcsBaseDomainObject}}}
]

{ #category : #private }
LcsSlotModelDiagramExamples >> domainObjectSlotModelClasses [
	| classes |
	classes := OrderedCollection new
			addAll: LcsBaseDomainObject withAllSuperclasses;
			addAll: LcsSlotModel withAllSuperclasses;
			addAll: LcsAccessorSlot withAllSuperclasses;
			yourself.
	classes removeDuplicates.
	classes remove: Object.
	self removeProtoObjectFrom: classes.
	^ classes
]

{ #category : #private }
LcsSlotModelDiagramExamples >> domainObjectSlotModelExplicitPositions [
	" (self root children collect: #position) storeString "

	^((Array new: 41) at: 1 put: ((141.0@62.0)); at: 2 put: ((168.0@ -44.0)); at: 3 put: ((432.0@104.0)); at: 4 put: ((-45.0@208.0)); at: 5 put: ((-57.0@98.0)); at: 6 put: ((-54.0@4.0)); at: 7 put: ((204.83931240957244@ -14.40216064453125)); at: 8 put: ((230.88809554858724@ -14.40216064453125)); at: 9 put: ((11.464190034155195@127.59783935546875)); at: 10 put: ((13.50293854148201@33.59783935546875)); at: 11 put: ((73.06665621843906@ -20.176059896217836)); at: 12 put: ((67.37199401855466@129.03707009403718)); at: 13 put: ((67.37199401855466@129.03707009403718)); at: 14 put: ((67.37199401855466@129.03707009403718)); at: 15 put: ((67.37199401855466@129.03707009403718)); at: 16 put: ((67.37199401855466@129.03707009403718)); at: 17 put: ((67.37199401855466@129.03707009403718)); at: 18 put: ((67.37199401855466@96.73297389503955)); at: 19 put: ((67.37199401855466@96.73297389503955)); at: 20 put: ((67.37199401855466@96.73297389503955)); at: 21 put: ((67.37199401855466@96.73297389503955)); at: 22 put: ((67.37199401855466@96.73297389503955)); at: 23 put: ((67.37199401855466@96.73297389503955)); at: 24 put: ((31.68990070533883@91.59783935546875)); at: 25 put: ((31.68990070533883@91.59783935546875)); at: 26 put: ((31.68990070533883@91.59783935546875)); at: 27 put: ((31.68990070533883@91.59783935546875)); at: 28 put: ((31.68990070533883@91.59783935546875)); at: 29 put: ((31.68990070533883@91.59783935546875)); at: 30 put: ((285.93800354003906@70.6921499896427)); at: 31 put: ((285.93800354003906@70.6921499896427)); at: 32 put: ((285.93800354003906@70.6921499896427)); at: 33 put: ((285.93800354003906@70.6921499896427)); at: 34 put: ((285.93800354003906@70.6921499896427)); at: 35 put: ((285.93800354003906@70.6921499896427)); at: 36 put: ((285.93800354003906@88.30711151733908)); at: 37 put: ((285.93800354003906@88.30711151733908)); at: 38 put: ((285.93800354003906@88.30711151733908)); at: 39 put: ((285.93800354003906@88.30711151733908)); at: 40 put: ((285.93800354003906@88.30711151733908)); at: 41 put: ((285.93800354003906@88.30711151733908)); yourself)
]

{ #category : #example }
LcsSlotModelDiagramExamples >> slotClassesHierarchy [
	<gtExample>
	^ UmlClassDiagram new classHierarchyFor: LcsBaseSlot withAllSubclasses
]

{ #category : #example }
LcsSlotModelDiagramExamples >> systemSlotModel [
	<gtExample>
	| model classes associations positions tempChildren |

	classes := self systemSlotModelClasses.
	associations := self systemSlotModelAssociationsWithLabels.
	positions := self systemSlotModelExplicitPositions.

	model := UmlClassDiagram new
		classHierarchyFor: classes
		withAssociationsAndLabels: associations.
		
	model layout custom: BlBasicLayout new.

	model root children withIndexDo: [ :child :n | child relocate: (positions at: n) ].
	
	^ model


]

{ #category : #private }
LcsSlotModelDiagramExamples >> systemSlotModelAssociationsWithLabels [
	^ {LcsSystem
			-> {{'systemSlotModel'.
						LcsSystemSlotModel}}.
		LcsSystemSlotModel
			-> {{'parent'.
						LcsSystem}}.
		LcsBaseDomainObject
			-> {{'slotModel'.
						LcsSlotModel}}.
		LcsSystemSlotModel
			-> {{'slotModels'.
						LcsSlotModel}}}
]

{ #category : #private }
LcsSlotModelDiagramExamples >> systemSlotModelClasses [
	| classes |
	classes := OrderedCollection new
			add: LcsSystem;
			addAll: LcsSystem allSuperclasses;
			add: LcsSystemSlotModel;
			add: LcsSlotModel;
			addAll: LcsSlotModel allSuperclasses;
			yourself.
	classes removeDuplicates.
	classes remove: Object.
	self removeProtoObjectFrom: classes.
	^ classes
]

{ #category : #private }
LcsSlotModelDiagramExamples >> systemSlotModelExplicitPositions [
	" (self root children collect: #position) storeString "

	^ {(32.0@ -60.0). (3.0@ -117.0). (-78.0@ -169.0). (-82.0@ -227.0). (-39.0@ -313.0). (-261.0@ -62.0). (-253.0@ -232.0). (58.667366562049665@ -87.40216064453125). (1.6271352610223744@ -139.40216064453122). (-17.01596050116575@ -197.40216064453122). (-8.50367832198333@ -283.40216064453125). (-169.4188209948952@ -139.40216064453122). (-169.87200735042012@ -284.0943769837845). (-125.93800354003906@ -46.6870949378922). (-125.93800354003906@ -46.6870949378922). (-125.93800354003906@ -46.6870949378922). (-125.93800354003906@ -46.6870949378922). (-125.93800354003906@ -46.6870949378922). (-125.93800354003906@ -46.6870949378922). (-125.93800354003906@ -46.6870949378922). (-125.93800354003906@ -77.6736544382739). (-125.93800354003906@ -77.6736544382739). (-125.93800354003906@ -77.6736544382739). (-125.93800354003906@ -77.6736544382739). (-125.93800354003906@ -77.6736544382739). (-125.93800354003906@ -77.6736544382739). (-125.93800354003906@ -77.6736544382739). (-161.09999847412112@ -216.0319821554862). (-161.09999847412112@ -216.0319821554862). (-161.09999847412112@ -216.0319821554862). (-161.09999847412112@ -216.0319821554862). (-161.09999847412112@ -216.0319821554862). (-161.09999847412112@ -216.0319821554862). (-161.09999847412112@ -216.0319821554862). (-228.3399326324463@ -202.40216064453122). (-228.3399326324463@ -202.40216064453122). (-228.3399326324463@ -202.40216064453122). (-228.3399326324463@ -202.40216064453122). (-228.3399326324463@ -202.40216064453122). (-228.3399326324463@ -202.40216064453122). (-228.3399326324463@ -202.40216064453122)}
]
