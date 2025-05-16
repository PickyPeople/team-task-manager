<template lang="pug">
  div.mt-5(style="max-height: 200px; overflow: auto;")
    h5.text-primary 進捗率
    Bar(:data="chartData" :options="chartOptions" )
</template>

<script setup>
import { computed } from 'vue'
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

console.log(props.progressData)

const chartData = computed(() => ({
  labels: props.progressData.map(p => p.name),
  datasets: [
    {
      label: '진척률 (%)',
      data: props.progressData.map(p => p.progress),
      backgroundColor: '#4e73df'
    }
  ]
}))

const chartOptions = {
  responsive: true,
  indexAxis: 'y', // 가로 막대그래프
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
        label: context => ` ${context.raw}% 완료`
      }
    }
  }
}
</script>