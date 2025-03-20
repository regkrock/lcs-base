Class {
	#name : #LcsSlotModelDiagramExamples,
	#superclass : #LcsObject,
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
						LcsSlotDefinition}}.
		LcsSlotDefinition
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
			addAll: LcsSlotDefinition withAllSuperclasses;
			yourself.
	classes removeDuplicates.
	classes remove: Object.
	self removeProtoObjectFrom: classes.
	^ classes
]

{ #category : #private }
LcsSlotModelDiagramExamples >> domainObjectSlotModelExplicitPositions [
	" (self root children collect: #position) storeString "

	^{(141.0@62.0). (168.0@ -44.0). (355.0@137.0). (-39.0@142.0). (-55.0@62.0). (-54.0@4.0). (204.83931240957244@ -14.40216064453125). (219.58789115366963@ -14.40216064453125). (15.595908597842211@91.59783935546875). (15.026441738738043@33.59783935546875). (73.06665621843906@ -20.176059896217836). (73.37199401855469@152.3975949093024). (73.37199401855469@152.3975949093024). (73.37199401855469@152.3975949093024). (73.37199401855469@152.3975949093024). (73.37199401855469@152.3975949093024). (73.37199401855469@152.3975949093024). (73.37199401855469@97.90663690014654). (73.37199401855469@97.90663690014654). (73.37199401855469@97.90663690014654). (73.37199401855469@97.90663690014654). (73.37199401855469@97.90663690014654). (73.37199401855469@97.90663690014654). (53.495702278759566@91.59783935546875). (53.495702278759566@91.59783935546875). (53.495702278759566@91.59783935546875). (53.495702278759566@91.59783935546875). (53.495702278759566@91.59783935546875). (53.495702278759566@91.59783935546875). (250.4625517059878@91.59783935546875). (250.4625517059878@91.59783935546875). (250.4625517059878@91.59783935546875). (250.4625517059878@91.59783935546875). (250.4625517059878@91.59783935546875). (250.4625517059878@91.59783935546875). (250.4625517059878@91.59783935546875). (250.4625517059878@91.59783935546875). (250.4625517059878@91.59783935546875). (250.4625517059878@91.59783935546875). (250.4625517059878@91.59783935546875). (250.4625517059878@91.59783935546875)}
]

{ #category : #example }
LcsSlotModelDiagramExamples >> slotDefinitionsHierarchy [
	<gtExample>
	^ UmlClassDiagram new classHierarchyFor: LcsSlotDefinition withAllSubclasses
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
