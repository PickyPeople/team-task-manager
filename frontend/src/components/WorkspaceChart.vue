<template lang="pug">
  div.mt-5.container(:style="{ height: `${containerHeight}px` }")
    h5.text-primary 進捗率
    Bar(:data="chartData" :options="chartOptions" )
</template>

<script setup>
import { computed, watch } from 'vue'
import { Bar } from 'vue-chartjs'
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale
} from 'chart.js'

ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

const props = defineProps({
  progressData: {
    type: Array,
    required: true
  }
})

const colorPalette = [
  '#4e73df', '#1cc88a', '#36b9cc', '#f6c23e', '#e74a3b',
  '#858796', '#fd7e14', '#20c997', '#6f42c1', '#f8f9fc'
]


const chartData = computed(() => ({
  labels: props.progressData.map(p => p.name),
  datasets: [
    {
      label: '진척률 (%)',
      data: props.progressData.map(p => p.progress),
      backgroundColor: props.progressData.map((_, index) => colorPalette[index % colorPalette.length])
    }
  ]
}))

const chartOptions = {
  responsive: true,
  maintainAspectRatio: false,  
  indexAxis: 'y',
  elements: {
    bar: {
      barThickness: 10, 
      borderRadius: 4
    }
  },
  scales: {
    x: {
      min: 0,
      max: 100,
      ticks: {
        callback: value => `${value}%`
      }
    }
  },
  plugins: {
    legend: { display: false },
    tooltip: {
      callbacks: {
        label: context => ` ${context.raw}% 完了`
      }
    }
  }
}

const containerHeight = computed(() => {
  const perPersonHeight = 35
  const padding = 50
  return props.progressData.length * perPersonHeight + padding
})


</script>

